#!/usr/bin/env perl

use strict;
use warnings;
use Linux::Inotify2;
use List::Util qw(sum);
use YAML;
use File::Spec;
use Cwd 'abs_path';
use Text::Glob qw( match_glob glob_to_regex );

#$|++;

#Bune unless no events
print "Bune 0.1.2 by Ilari Mäkelä\n\n";

die "Usage: $0 yaml directory\n\n" unless @ARGV eq 2;

my ($yamlArg, $directory) = @ARGV;
#$directory =~ s/\/+$//;
$directory = abs_path($directory);

die "Yaml $yamlArg not found!\n\n" unless -f $yamlArg;
die "Folder $directory not found\n\n" unless -d $directory;

sub eventMask {
    my $event = shift;
    my %events;
    $events{scalar IN_CREATE} = "CREATE";
    $events{scalar IN_DELETE} = "DELETE";
    $events{scalar IN_MODIFY} = "MODIFY";
    $events{scalar IN_MOVED_TO} = "MOVE";

    return $event eq -1 
        ? sum( keys %events )
        : $events{$event} || $event;
}

sub yamlReader {
    open my $filehandler, '<', shift 
      or die "can't open yaml file: $!";

    # step 2: slurp file contents
    my $yaml = do { local $/; <$filehandler> };

    # step 3: convert YAML 'stream' to hash ref
    Load($yaml);
}

my $yaml = yamlReader($yamlArg);

my $inotify = new Linux::Inotify2 
    or die "Unable to create new inotify object: $!";

$inotify->watch(
    $directory,
    eventMask(-1),
    sub {
        my $event = shift;
        my $file = substr($event->fullname, length($directory) + 1);

        my $mask = eventMask($event->mask);
	my $regex;
	
	foreach my $task ($yaml->{task}) {
	    $regex = glob_to_regex( $task->{match} );
	    print "matched: $task->{run}\n" if /$regex/;
	}

        print "$mask $file\n";
    }
) or die "watch creation failed: $!";

1 while $inotify->poll;

