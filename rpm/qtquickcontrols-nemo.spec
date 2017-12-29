Name:       qt5-qtquickcontrols-nemo
Summary:    Nemomobile Qt Quick Controls
Version:    5.3.2
Release:    nemo1
Group:      System/Library
License:    LGPLv2.1 with exception or GPLv3
URL:        https://github.com/nemomobile/qtquickcontrols-nemo
Source0:    %{name}-%{version}.tar.xz
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  fdupes

Requires:   qt5-qtquickcontrols
Requires:   qt5-qtgraphicaleffects
Requires:   nemo-theme-glacier

%description
Qt is a cross-platform application and UI framework. Using Qt, you can
write web-enabled applications once and deploy them across desktop,
mobile and embedded systems without rewriting the source code.
.
This package contains the Qt Quick Controls library

%package examples
Summary:    Examples to showcase Nemo UI components
Requires:   %{name}
Requires:   nemo-qml-plugin-notifications-qt5
Requires:   libglacierapp
BuildRequires:  desktop-file-utils
BuildRequires:  pkgconfig(glacierapp)

%description examples
%{summary}.

#### Build section

%prep
%setup -q -n %{name}-%{version}

%build
export QTDIR=/usr/share/qt5
touch .git # To make sure syncqt is used

%qmake5
make %{?_smp_flags}

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

#### Pre/Post section

%post
/sbin/ldconfig
%postun
/sbin/ldconfig

#### File section

%files
%defattr(-,root,root,-)
%{_libdir}/qt5/qml/Nemo/Dialogs
%{_libdir}/qt5/qml/Nemo/UX/Models
%{_libdir}/qt5/qml/QtQuick/Controls/Nemo
%{_libdir}/qt5/qml/QtQuick/Controls/Styles/Nemo

%files examples
%defattr(-,root,root,-)
%{_bindir}/glacier-components
%{_datadir}/glacier-components
%{_datadir}/applications/*.desktop

