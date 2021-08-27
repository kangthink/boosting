

PROJECT_NAME=$1

yarn create next-app --typescript $PROJECT_NAME && \
mkdir $PROJECT_NAME/.vscode && \
touch $PROJECT_NAME/.vscode/settings.json && \
cat << EOF > $PROJECT_NAME/.vscode/settings.json
{
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true,
    "prettier.jsxSingleQuote": true,
    "prettier.useTabs": false,
    "prettier.tabWidth": 2,
    "prettier.semi": false
}
EOF

touch $PROJECT_NAME/.vscode/extensions.json && \
cat << EOF > $PROJECT_NAME/.vscode/extensions.json
{
    "recommendations": [
        "esbenp.prettier-vscode"
    ]
}
EOF

cd $PROJECT_NAME && \
yarn add -D tailwindcss@latest postcss@latest autoprefixer@latest && \
npx tailwindcss init -p
cat << EOF > tailwind.config.js
module.exports = {
  mode: 'jit',
  purge: ['./pages/**/*.{js,ts,jsx,tsx}', './components/**/*.{js,ts,jsx,tsx}'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
  extend: {},
  },
  plugins: [],
}
EOF

cd .. && \
rm $PROJECT_NAME/styles/Home.module.css && \
cat << EOF > $PROJECT_NAME/styles/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

cat << EOF > $PROJECT_NAME/pages/index.tsx
import type { NextPage } from 'next'
import Head from 'next/head'


const Page: React.FC = ({ children }) => {
    return <div className='bg-gray-300'>{children}</div>
}

const Main: React.FC = ({ children }) => {
  return <main className='bg-gray-400'>{children}</main>
}

const Home: NextPage = () => {
  return (
  <Page>
    <Head>
      <title>Create Next App</title>
      <meta name="description" content="Generated by create next app" />
      <link rel="icon" href="/favicon.ico" />
    </Head>
    <Main>
      this is main...
    </Main>
  </Page>
  )
}

export default Home
EOF
