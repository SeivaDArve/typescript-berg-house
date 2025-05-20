#!/bin/bash
# Title: Criar app que diz "hello World" No browser
# Description: Script que cria automativamente esse projeto

clear 

function f_create_all_files {
   # Criado pelo ChatGPT, em vez de fornecer um .zip com todos estes ficheiros, escreveu este script bash que imita tudo

   # Cria a pasta do projeto
      mkdir hello-web-rn && cd hello-web-rn
      npm init -y

   # Instala as dependências principais
      npm install     \
         react        \
         react-dom    \
         react-native \
         react-native-web

   # Instala ferramentas de desenvolvimento
      npm install --save-dev \
         typescript          \
         @types/react        \
         @types/react-dom    \
         webpack             \
         webpack-cli         \
         webpack-dev-server  \
         ts-loader           \ 
         html-webpack-plugin

   # Cria a estrutura de ficheiros
      mkdir src public

   # Cria o index.tsx
   cat > src/index.tsx << 'EOF'
   import React from 'react';
   import { AppRegistry, Text, View } from 'react-native';
   import { name as appName } from '../package.json';

   const App = () => (
     <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
       <Text>Hello World</Text>
     </View>
   );

   AppRegistry.registerComponent(appName, () => App);
   AppRegistry.runApplication(appName, {
     rootTag: document.getElementById('root'),
   });
   EOF

   # Cria o index.html
   cat > public/index.html << 'EOF'
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <meta charset="UTF-8" />
       <title>Hello Web RN</title>
     </head>
     <body>
       <div id="root"></div>
     </body>
   </html>
   EOF

   # Cria o tsconfig.json
   cat > tsconfig.json << 'EOF'
   {
     "compilerOptions": {
       "target": "es6",
       "module": "esnext",
       "jsx": "react",
       "strict": true,
       "esModuleInterop": true,
       "moduleResolution": "node",
       "skipLibCheck": true,
       "forceConsistentCasingInFileNames": true
     },
     "include": ["src"]
   }
   EOF

   # Cria o webpack.config.js
   cat > webpack.config.js << 'EOF'
   const path = require('path');
   const HtmlWebpackPlugin = require('html-webpack-plugin');

   module.exports = {
     entry: './src/index.tsx',
     output: {
       filename: 'bundle.js',
       path: path.resolve(__dirname, 'dist'),
     },
     resolve: {
       extensions: ['.tsx', '.ts', '.js'],
       alias: {
         'react-native$': 'react-native-web'
       }
     },
     module: {
       rules: [
         {
           test: /\.(ts|tsx)$/,
           use: 'ts-loader',
           exclude: /node_modules/
         }
       ]
     },
     plugins: [
       new HtmlWebpackPlugin({
         template: './public/index.html'
       })
     ],
     devServer: {
       static: './dist',
       hot: true,
       port: 3000
     }
   };
   EOF

   # Atualiza o package.json para definir os scripts
   npx npm-add-script -k start -v "webpack serve --mode development"
   npx npm-add-script -k build -v "webpack --mode production
}

function f_corrigir_erro {
   echo 
   echo "no ficheiro: src/index.tsx"
   echo "  Substituir: \`import { name as appName } from \'../package.json\'\;"
   echo "  Por: const appName = \'HelloWebRN\'\;"
   echo 
}

function f_exec_web_server {
   echo "Para mostrar os resultados da nossa app no browser:"
   echo " > \`npm run start\`"
   echo 
   echo "Depois abrir o browser e visitar:"
   echo " > http://localhost:3000"
}

function f_partilhar_webpage_com_smartphone_browser {
   echo "Apos rodar o servidor local com: Ola Mundo,"
   echo "é possivel que o android tambem veja essa webpage"
   echo 
   echo "Para visitar a mesma webpage no android:"
   echo "1. Descobrir o IP local do PC"
   echo "   Pode ser usado \`D ip\` para que DRYa dê o IP local"
   echo "   O IP será algo como 192.168.1.42"
   echo 
   echo "2. Atualizar o ficheiro  webpack.config.js, especificamente em 'devServer'"
   echo "   devServer: {"
   echo "     static: './dist',"
   echo "     hot: true,"
   echo "     port: 3000,"
   echo "     host: '0.0.0.0' // <-- esta linha é essencial"
   echo "   }
   echo
   echo "3. recomecar o servidor:"
   echo '   `npm run start`'
   echo 
   echo "4. No smartphone, abre o navegador e visita:"
   echo "   http://192.168.1.42:3000"
}

function f_partilhar_temporariamente_localhost_com_o_mundo {
   echo "ngrok é um software que partilha o nosso local host publicamente (ate Ctrl-C)"
   echo " exemplo: http://abcd1234.ngrok.io"
   echo
   echo "Porem, nao vem nos repositorios padrao do Fedora Linux"
   echo ' > mas pode ser instalado com `snap`'
   echo ' > `sudo snap install ngrok`'
   echo 
   echo "Fornece o numero da porta ao ngrok para ele criar automaticamente um endereco publico"
   echo ' > `ngrok http 3000`'
   echo '    (agora este software, apesar de ser gratis, pede para criar conta de utilizador)' 
}

function f_exec {
   #f_create_all_files
   f_corrigir_erro
   f_exec_web_server
   f_partilhar_webpage_com_smartphone_browser
   f_partilhar_temporariamente_localhost_com_o_mundo
}
f_exec
