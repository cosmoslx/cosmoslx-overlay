# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils

DESCRIPTION="a simple cross-platform application for cropping PDF files. A simple user interface lets you define exactly the crop-region by fitting a rectangle on the visually overlaid pages"
HOMEPAGE="http://briss.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-bin.tar.gz"
#SRC_URI="http://sourceforge.net/projects/briss/files/release%200.0.13/briss-0.0.13-bin.tar.gz/download"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virutal/jre-1.6"
RDEPEND="${DEPEND}"

src_configure() {
	einfo "Nothing to configure"
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /opt/briss || die "can't create /opt/briss"

	insinto /opt/briss
	doins *.jar || die "can't install *.jar"

	exeinto /opt/briss
	doexe "${FILESDIR}"/briss-bin || die "can't install briss-bin"
	dosym  /opt/briss/briss-bin /opt/bin/ || die "can't create symlink"

	make_desktop_entry briss briss briss Utility
}
