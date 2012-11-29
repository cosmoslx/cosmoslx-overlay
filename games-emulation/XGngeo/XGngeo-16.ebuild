# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit eutils games distutils

MY_P="${P}_final"
MY_PN="${PN/XG/xg}"

DESCRIPTION="GTK2 Gngeo frontend written in Python"
HOMEPAGE="http://www.choplair.org/?en/XGngeo"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.bz2"
#SRC_URI="http://download.berlios.de/xgngeo/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""
RDEPEND="
	>=x11-libs/gtk+-2
	>=dev-lang/python-2
	>=dev-python/pygtk-2
	games-emulation/gngeo"

#S="${WORKDIR}/${P}"

src_prepare() {
	epatch "${FILESDIR}/XGngeo-16-gentoo-paths.patch"
}

src_install() {
	distutils_src_install
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
}
