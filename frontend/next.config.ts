
import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
    typescript: {
        ignoreBuildErrors: true,
    },
    images: {
        remotePatterns: [
            { protocol: 'https', hostname: 'img.freepik.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'magazine.caser.es', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'ridejohndoe.com.co', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'cdn.motor1.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'media.revistagq.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 's3.us-west-1.amazonaws.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'cdn.shopify.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'i.pinimg.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'okdiario.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'topmotors.pe', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'www.amv.es', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'motos.honda.com.co', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'www.moto1pro.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'autoshowtv.com.mx', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'somosmoto.pe', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'encrypted-tbn0.gstatic.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'w7.pngwing.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'vectorseek.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'e7.pngegg.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'upload.wikimedia.org', port: '', pathname: '/**' },
            { protocol: 'https', hostname: '1000marcas.net', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'cdn.store.link', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'pbs.twimg.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'flux.somosmoto.pe', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'motollopis.es', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'scontent.flim2-1.fna.fbcdn.net', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'www.rezziomotocicletas.com.pe', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'flux.somosmoto.pe', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'static.wixstatic.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'bm3motos.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'www.yamaha-motor.com.pe', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'goo.su', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'i.imgur.com', port: '', pathname: '/**' },
            { protocol: 'https', hostname: 'drive.google.com', port: '', pathname: '/uc*' }
        ],
    },
    async rewrites() {
        return [
            {
                source: '/api/:path*',
                destination: `${process.env.BACKEND_ORIGIN || 'http://localhost:8000'}/:path*`,
            },
            {
                source: '/uploads/:path*',
                destination: `${process.env.BACKEND_ORIGIN || 'http://localhost:8000'}/uploads/:path*`,
            },
        ];
    },
    output: 'standalone',
};


export default nextConfig;
