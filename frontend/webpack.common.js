const webpack = require('webpack');
const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');

module.exports = {
    entry: './src/index.js',
    output: {
        path: path.resolve(__dirname, 'public'),
        filename: 'bundle.js',
    },
    module: {
        rules: [
            {
                test: /\.vue$/,
                exclude: /node_modules/,
                loader: 'vue-loader',
            },
            {
                test: /\.less$/,
                exclude: /node_modules/,
                use: [
                    process.env.NODE_ENV !== 'production' ? 'vue-style-loader' : MiniCssExtractPlugin.loader,
                    'css-loader',
                    'less-loader',
                ],
            },
            {
                test: /\.css$/,
                use: [
                    'vue-style-loader',
                    {
                        loader: 'css-loader',
                    }
                ]
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/env'],
                    },
                },
            },
        ],
    },
    plugins: [
        new VueLoaderPlugin(),
        new MiniCssExtractPlugin({
            filename: 'style.css',
        }),
        new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/),
    ],
    resolve: {
        modules: ['node_modules', 'src'],
        extensions: ['.js', '.vue', '.less', '.json'],
        alias: {
            vue: 'vue/dist/vue.js',
            'vue$': 'vue/dist/vue.esm.js',
        },
    },
};