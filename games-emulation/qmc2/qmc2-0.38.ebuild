# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games confutils

DESCRIPTION="An MAME frontend for SDLMAME/SDLMESS"
HOMEPAGE="http://www.mameworld.net/mamecat/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug joystick opengl phonon +sdlmame sdlmess sqlite"

DEPEND=">=dev-qt/qtgui-4.5:4[accessibility]
	>=dev-qt/qtwebkit-4.5:4
	phonon? ( || ( 
					media-libs/phonon 
					>=dev-qt/qtphonon-4.5
			) )
	joystick? ( media-libs/libsdl[joystick] )
	opengl? ( >=dev-qt/qtopengl-4.5:4 )
	sqlite? ( >=dev-qt/qtsql-4.5:4[sqlite] )"

RDEPEND="${DEPEND}
	sdlmame? ( games-emulation/sdlmame )
	sdlmess? ( games-emulation/sdlmess )
	x11-apps/xwininfo"

S="${WORKDIR}/${PN}"

pkg_setup() {
	# Make sure at least one is selected
	confutils_require_any sdlmame sdlmess

	# Set proper parameters for make
	FLAGS="DESTDIR=${D} PREFIX=\"${GAMES_PREFIX}\" DATADIR=\"${GAMES_DATADIR}\" CTIME=0"

	use debug || FLAGS="${FLAGS} DEBUG=0"
	use joystick || FLAGS="${FLAGS} JOYSTICK=0"
	use opengl && FLAGS="${FLAGS} OPENGL=1"
	use phonon || FLAGS="${FLAGS} PHONON=0"
	use sqlite && FLAGS="${FLAGS} DATABASE=1"
}

src_prepare() {
	use sdlmess && cp -r "${S}" "${WORKDIR}/${PN}-sdlmess"
}

src_compile() {
	if use sdlmame
	then
	    emake ${FLAGS} EMULATOR=SDLMAME || die "make failed"
	fi

	if use sdlmess
	then
	    cd "${WORKDIR}/${PN}-sdlmess"
	    emake ${FLAGS} EMULATOR=SDLMESS || die "make failed"
	fi
}

src_install() {
	if use sdlmame
	then
	    emake ${FLAGS} EMULATOR=SDLMAME install || die "make install failed"
	fi

	if use sdlmess
	then
	    cd "${WORKDIR}/${PN}-sdlmess"
	    emake ${FLAGS} EMULATOR=SDLMESS install || die "make install failed"
	fi

	## reusing the package desktop file
	mv "${D}/usr/share/games/applications" "${D}/usr/share/" && einfo "Reusing desktop file ..."

	prepgamesdirs
}
