# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="A tool for reengineering 3rd party, closed, binary Android apps."
HOMEPAGE="http://code.google.com/p/android-apktool/"
SRC_URI="http://android-${PN}.googlecode.com/files/${PN}${PV}.tar.bz2
	http://android-${PN}.googlecode.com/files/${PN}-install-linux-r05-ibot.tar.bz2"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
RDEPEND="dev-util/android-sdk-update-manager"

src_prepare() {
	mv apktool-install-linux-r05-ibot/* .
	# fixed libdir
	sed -i "s|libdir=\"\$progdir\"|libdir=\"/opt/${PN}/lib\"|" apktool || die "fixed libdir error"
}

src_install() {
	install_path="/opt/${PN}"
	dodir ${install_path}
	exeinto ${install_path}
	doexe apktool
	doexe aapt

	lib_path="${install_path}/lib"
	dodir ${lib_path}
	insinto ${lib_path}
	doins apktool.jar

	dosym "${install_path}/apktool" /opt/bin/apktool
	dosym "${install_path}/aapt" /opt/bin/aapt
}
