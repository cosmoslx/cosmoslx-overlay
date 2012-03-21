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
	einfo "Changing game resources hardcode path..."

	sed -i -e "s:samples/:"${GAMES_DATADIR}"/"${PN}"/samples/:g" -i config/samples.def

	find src -name *.[ch] -exec \
		sed -i '{}' \
			-e "s:config/samples:"${GAMES_DATADIR}"/"${PN}"/config/samples:g" \
			-e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g" \
			-e "s:languages/:"${GAMES_DATADIR}"/"${PN}"/languages/:g" \
			-e "s:levels/:"${GAMES_DATADIR}"/"${PN}/levels/":g" \
			-e "s:musics/:"${GAMES_DATADIR}"/"${PN}/musics/":g" \
			-e "s:objects/:"${GAMES_DATADIR}"/"${PN}/objects/":g" \
			-e "s:quests/:"${GAMES_DATADIR}"/"${PN}"/quests/:g" \
			-e "s:sprites/:"${GAMES_DATADIR}"/"${PN}"/sprites/:g" \
			-e "s:samples/:"${GAMES_DATADIR}"/"${PN}/samples/":g" \
			-e "s:themes/:"${GAMES_DATADIR}"/"${PN}/themes/":g" \;

	find sprites -name *.spr -exec \
		sed -i '{}' -e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g" \;

	find themes \( -name *.brk -o -name *.bg \) -exec \
		sed -i '{}' -e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g" \;

	find quests -name *.qst -exec \
		sed -i '{}' \
			-e "s:images/:"${GAMES_DATADIR}"/"${PN}/images/":g" \
			-e "s:levels/:"${GAMES_DATADIR}"/"${PN}/levels/":g" \;

	find levels -name *.lev -exec \
		sed -i '{}' \
			-e "s:musics/:"${GAMES_DATADIR}"/"${PN}/musics/":g" \
			-e "s:themes/:"${GAMES_DATADIR}"/"${PN}/themes/":g" \;
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
