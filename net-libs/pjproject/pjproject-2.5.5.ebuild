# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit flag-o-matic

DESCRIPTION="Open source SIP, Media, and NAT Traversal Library"
HOMEPAGE="http://www.pjsip.org/"
SRC_URI="http://www.pjsip.org/release/${PV}/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="2/9999"
CODEC_FLAGS="g711 g722 g7221 gsm ilbc speex l16"
VIDEO_FLAGS="sdl ffmpeg v4l2 openh264 libyuv"
SOUND_FLAGS="alsa oss portaudio"
IUSE="amr debug doc epoll examples +gnutls ipv6 opus resample silk +ssl static-libs webrtc ${CODEC_FLAGS} ${VIDEO_FLAGS} ${SOUND_FLAGS}"

RDEPEND="alsa? ( media-libs/alsa-lib )
	oss? ( media-libs/portaudio[oss] )
	portaudio? ( media-libs/portaudio )

	amr? ( media-libs/opencore-amr )
	gsm? ( media-sound/gsm )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	opus? ( media-libs/opus )
	speex? ( media-libs/speex )

	ffmpeg? ( virtual/ffmpeg:= )
	sdl? ( media-libs/libsdl )
	openh264? ( media-libs/openh264 )
	resample? ( media-libs/libsamplerate )

	ssl? (
		gnutls? ( >=net-libs/gnutls-3.4.14:= )
		!gnutls? ( dev-libs/openssl:= )
			)

	net-libs/libsrtp:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="?? ( ${SOUND_FLAGS} )
	gnutls? ( ssl )"

PATCHES=(
	"${FILESDIR}/endianness.patch"
	"${FILESDIR}/gnutls.patch"
	"${FILESDIR}/ipv6.patch"
	"${FILESDIR}/ice_config.patch"
	"${FILESDIR}/multiple_listeners.patch"
	"${FILESDIR}/pj_ice_sess.patch"
	"${FILESDIR}/fix_turn_fallback.patch"
	"${FILESDIR}/fix_ioqueue_ipv6_sendto.patch"
	"${FILESDIR}/add_dtls_transport.patch"
)

src_configure() {
	local myconf=()
	local videnable="--disable-video"
	local t

	use ipv6 && append-cppflags -DPJ_HAS_IPV6=1
	use debug || append-cppflags -DNDEBUG=1

	for t in ${CODEC_FLAGS}; do
		myconf+=( $(use_enable ${t} ${t}-codec) )
	done

	for t in ${VIDEO_FLAGS}; do
		myconf+=( $(use_enable ${t}) )
		use "${t}" && videnable="--enable-video"
	done

	if use ssl && use gnutls ; then
		myconf+=( --enable-ssl=gnutls)
	elif use ssl && ! use gnutls ; then
		myconf+=( --enable-ssl=openssl)
	else
		myconf+=( --disable-ssl)
	fi

	econf \
		--enable-shared \
		--with-external-srtp \
		${videnable} \
		$(use_enable epoll) \
		$(use_with gsm external-gsm) \
		$(use_with speex external-speex) \
		$(use_enable speex speex-aec) \
		$(use_enable resample) \
		$(use_enable resample libsamplerate) \
		$(use_enable resample resample-dll) \
		$(use_enable alsa sound) \
		$(use_enable oss) \
		$(use_with portaudio external-pa) \
		$(use_enable portaudio ext-sound) \
		$(use_enable amr opencore-amr) \
		$(use_enable silk) \
		$(use_enable opus) \
		$(use_enable webrtc) \
		"${myconf[@]}"
}

src_compile() {
	emake dep
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	if use doc; then
		dodoc README.txt README-RTEMS
	fi

	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		doins -r pjsip-apps/src/samples
	fi

	use static-libs || rm "${D}/usr/$(get_libdir)/*.a"
}

pkg_postinst() {
	if use gnutls ; then
		ewarn "You are using a patched library with gnutls patch"
		ewarn "There is no guarantee that it will work with any software besides net-voip/ring-daemon"
	elif use ssl && ! use gnutls ; then
		ewarn "The gnutls is necessary for net-voip/ring-daemon"
	fi
}
