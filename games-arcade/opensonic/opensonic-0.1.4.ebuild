# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games cmake-utils

MY_PN=opensnc
MY_P=${MY_PN}-src-${PV}

DESCRIPTION="Open Sonic is a free open-source game based on the Sonic the Hedgehog universe."
HOMEPAGE="http://opensnc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=media-libs/allegro-4.4*[X,png,jpeg,vorbis]
	media-libs/libogg"

DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch ${FILESDIR}/opensnc-0.1.4-fix-hardcode-path.patch

	#einfo "Changing game resources hardcode path..."

	#sed -i -e "s:sprites/:"${GAMES_DATADIR}"/"${PN}"/sprites/:g" -i src/core/sprite.c
	#sed -i -e "s:languages/:"${GAMES_DATADIR}"/"${PN}"/languages/:g" -i src/core/lang.h
	#sed -i -e "s:samples/:"${GAMES_DATADIR}"/"${PN}"/samples/:g" -i config/samples.def
	#sed -i -e "s:languages/:"${GAMES_DATADIR}"/"${PN}"/languages/:g" -i src/scenes/langselect.c
	#sed -i -e "s:quests/:"${GAMES_DATADIR}"/"${PN}"/quests/:g" -i src/scenes/menu.c
	#for i in `find sprites -name *.spr`; do sed -i "$i" -e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g"; done
	#for i in `find src -name *.[ch]`; do sed -i "$i" -e "s:config/samples:"${GAMES_DATADIR}"/"${PN}"/config/samples:g";done
	#for i in `find src -name *.[ch]`; do sed -i "$i" -e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g"; done
	#for i in `find src -name *.[ch]`; do sed -i "$i" -e "s:levels/:"${GAMES_DATADIR}"/"${PN}/levels/":g"; done
	#for i in `find src -name *.[ch]`; do sed -i "$i" -e "s:musics/:"${GAMES_DATADIR}"/"${PN}/musics/":g"; done
	#for i in `find src -name *.[ch]`; do sed -i "$i" -e "s:objects/:"${GAMES_DATADIR}"/"${PN}/objects/":g"; done
	#for i in `find src -name *.[ch]`; do sed -i "$i" -e "s:samples/:"${GAMES_DATADIR}"/"${PN}/samples/":g"; done
	#for i in `find src -name *.[ch]`; do sed -i "$i" -e "s:themes/:"${GAMES_DATADIR}"/"${PN}/themes/":g"; done
	#for i in `find themes -name *.brk`; do sed -i "$i" -e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g"; done
	#for i in `find themes -name *.bg`; do sed -i "$i" -e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g"; done
	#for i in `find quests -name *.qst`; do sed -i "$i" -e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g"; done
	#for i in `find quests -name *.qst`; do sed -i "$i" -e "s:levels/:"${GAMES_DATADIR}"/"${PN}/levels/":g"; done
	#for i in `find levels -name *.lev`; do sed -i "$i" -e "s:musics/:"${GAMES_DATADIR}"/"${PN}/musics/":g"; done
	#for i in `find levels -name *.lev`; do sed -i "$i" -e "s:themes/:"${GAMES_DATADIR}"/"${PN}/themes/":g"; done
}

src_configure() {
	export _ALLEGRO_LIBS=`allegro-config --libs`
	export _ALLEGRO_VERSION=`allegro-config --version`
	cmake-utils_src_configure
}

src_install() {
	local datadir="${GAMES_DATADIR}"/${PN}
	insinto "${datadir}"
	doins -r config images languages levels licenses musics objects quests sprites \
	samples screenshots themes || die "data install failed"

	dogamesbin "${CMAKE_BUILD_DIR}"/${PN} || die

	newicon icon.png "${PN}".png || die
	make_desktop_entry "${PN}" "${PN}"
	dohtml readme.html || die

	prepgamesdirs
}
