PROJECT_NAME=$1

yarn create next-app --typescript $PROJECT_NAME && \
mkdir $PROJECT_NAME/.vscode && \
touch $PROJECT_NAME/.vscode/settings.json && \
cat << EOF > $PROJECT_NAME/.vscode/settings.json
{
    "editor.defaultFormatter": "remimarsal.prettier-now",
    "editor.formatOnSave": true,
    "prettier.jsxSingleQuote": true,
    "prettier.useTabs": false,
    "prettier.tabWidth": 2,
    "prettier.semi": false
}
EOF

cd $PROJECT_NAME && \
yarn add --dev typescript @types/react @types/node && \
yarn add @chakra-ui/react @emotion/react@^11 @emotion/styled@^11 framer-motion@^4 && \
cat << EOF > pages/index.tsx
import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'

import { ChakraProvider, Container, Flex, Box, Spacer } from '@chakra-ui/react'

export default function Home() {
  const pageWrapperStyle = {}

  return (
    <ChakraProvider>
      <Head>
        <title>타이틀</title>
      </Head>
      <Box minH='100vh' bg='#F1EFE9' pos='relative'>
        <header>
          <nav>
            <Flex bg='#efefef'>
              <Box p={[ 4, 6 ]}>로고</Box>
              <Spacer />
              <Box p={[ 4, 6 ]}>메뉴</Box>
            </Flex>
          </nav>
        </header>
        <main>
          <Container>
            There are many benefits to a joint design and development system. Not only does it bring benefits to the
            design team, but it also brings benefits to engineering teams. It makes sure that our experiences have a
            consistent lookddsdfsf and feel, not just in our design specs, but in production
          </Container>
        </main>
      </Box>
      <Box as='footer' p={10} bg='#F1EFaa'>
        footer
      </Box>
    </ChakraProvider>
  )
}

EOF

cat << EOF > pages/_app.tsx
import '../styles/globals.css'
import { AppProps } from 'next/app'

function MyApp({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}
export default MyApp

EOF