# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils multilib

DESCRIPTION="Converts files between the .dwg and .dxf file formats"
HOMEPAGE="http://www.opendesign.com/guestfiles"

URL_64="https://download.opendesign.com/guestfiles/Demo/ODAFileConverter_QT5_lnxX64_7.2dll_21.11.deb"

SRC_URI="
	amd64? ( ${URL_64} )
"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

RESTRICT="mirror"

DEPEND="
	dev-qt/qtcore
	x11-themes/hicolor-icon-theme
"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack $A
	unpack ./data.tar.xz
	cd ./usr
}

src_install() {
	exeinto /usr/bin
	doexe usr/bin/ODAFileConverter
	ODAFileConverter_${PV}
	exeinto /usr/bin/ODAFileConverter_${PV}
	doexe usr/bin/ODAFileConverter_${PV}/*
	domenu usr/share/applications/ODAFileConverter_${PV}.desktop
	doicon -s 16 usr/share/icons/hicolor/16x16/apps/ODAFileConverter.png
	doicon -s 32 usr/share/icons/hicolor/32x32/apps/ODAFileConverter.png
	doicon -s 64 usr/share/icons/hicolor/64x64/apps/ODAFileConverter.png
	doicon -s 128 usr/share/icons/hicolor/128x128/apps/ODAFileConverter.png
}

