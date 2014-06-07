Name:           bune
Version:        0.0.2
Release:        1
Summary:        Bune unless no events
License:        GPL
Vendor:         ilarimakela
URL:            http://www.github.com/ilarimakela
Group:          Development/Tools
Packager:       Ilari Makela <ilari.makela@spoonfactory.fi>
Requires:       perl
Requires:       perl-Linux-Inotify2
Requires:       perl-YAML
AutoReqProv:    yes
BuildArch:      noarch
Prefix:         /opt/ilarimakela/bune

%description
Bune unless no events


%prep
cd $RPM_SOURCE_DIR
cp -a /data/src/. .
chown -R root.root .
chmod -R a+rX,g-w,o-w .


%build


%install
mkdir -p $RPM_BUILD_ROOT/%{prefix}
cp -a $RPM_SOURCE_DIR/. $RPM_BUILD_ROOT/%{prefix}
#tar czf %{getenv:PWD}/../dist/%{name}-%{version}.tar.gz -C $RPM_BUILD_ROOT .%{prefix}
tar czf /data/dist/%{name}-%{version}.tar.gz -C $RPM_BUILD_ROOT .%{prefix}


%clean
mv %_rpmdir/*/%{name}*.rpm /data/dist


%post
ln -s %{prefix}/bune.pl /usr/bin/bune


%files
%defattr(0555,root,root,0550)
%{prefix}
