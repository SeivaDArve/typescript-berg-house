#!/bin/bash
# Title: Criar app que diz "hello World" No browser
# Description: Script que cria automativamente esse projeto

# Criado pelo ChatGPT, em vez de fornecer um .zip com todos estes ficheiros, escreveu este script bash que imita tudo

# uDev: Criar apk para playstore. Com nome da nova empresa, com novo email. (Exemplos de nomes na empresa de software: onPress)

clear 

function f_db {
   echo "Debug stop"
   exit 
}

function f_create_project_directory {
   # Cria a pasta do projeto (petgunta o nome ao utilizador)   
      # exemplo: `mkdir hello-web-rn && cd hello-web-rn`  

   # Perguntar nome ao utilizador
      read -p "DRYa: Ts: Introduza novo nome de projeto: " v_name

   # Navegar para a pasta de projetos e criar o novo projeto
      v_projetos=${v_REPOS_CENTER}/typescript-berg-house/all/Projetos
      cd $v_projetos

      mkdir $v_name && cd $v_name  
}

function f_config_com_npm {
   # Utilizar `npm` (node package manager)
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
}

function f_create_file_from_heredoc_1 {
   # Criar o index.tsx
   # uDev: Apagar 3 primeiros espacos em branco em cada linha

   # A funcao anterior `f_config_com_npm` ja criou a pasta ./src mas, se por motivos de debug essa fx for anulada/comentada/apagada, entao teremos de criar essa pasta de novo
      mkdir -p src

   cat > src/index.tsx << "EOF"
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
}

function f_create_file_from_heredoc_2 {
   # Cria o tsconfig.json
   # uDev: Apagar 3 primeiros espacos em branco em cada linha

   cat > tsconfig.json << "EOF"
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
}


function f_create_file_from_heredoc_3 {
   # Cria o webpack.config.js
   # uDev: Apagar 3 primeiros espacos em branco em cada linha

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
}


function f_create_all_files {
   # Criar ficheiros apartir deste script (em vez de compactar em .zip)

   f_create_file_from_heredoc_1
   f_create_file_from_heredoc_2
   f_create_file_from_heredoc_3
}
 

function f_npx {
   # Atualiza o package.json para definir os scripts
   npx npm-add-script -k start -v "webpack serve --mode development"
   npx npm-add-script -k build -v "webpack --mode production"
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
   echo "   }"
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

function f_detect_weather_using_expo_or_not {
   # Como saber se estamos no expo managed workfow ou se estamos no  React Native Bare workflow?
   
   :' Comwntario:

      `grep -q padrao ficheiro.txt`  
      -q, --quiet, --silent
          Quiet; do not write anything to standard output.  Exit
          immediately with zero status if any match is found,
          even if an error was detected.
   '

   if [ -f "app.json" ] && grep -q '"expo"' app.json; then
      if [ -d "android" ] && [ -d "ios" ]; then
          echo "React Native Bare Workflow (ejetado do Expo)"
      else
          echo "Expo Managed Workflow"
      fi

   elif [ -f "package.json" ] && grep -q '"react-native"' package.json; then
       echo "React Native Bare Workflow (sem Expo)"
   else
       echo "Não parece ser um projeto React Native ou Expo"
   fi
}

function f_add_gitignore {
   # Criar ficheiro .gitignore
   
   :'
   Nem sempre os templates que usamos para criar nova app vem com .gitignore e ha uma pasta muito importante para se adicionar ao .gitignore
   
   Pasta importante a adicionar: "node_modules/" 
   
   Apartir do ficheiro package.json da para criar package-lock.json e node_modules/
   
   O arquivo responsável por recriar a pasta node_modules/ do zero é o package.json — e opcionalmente o package-lock.json (ou yarn.lock, se usar Yarn).

   Se tivermos apenas package.json, podemos executar `npm install` para ler todas as dependências listadas em package.json, baixar e instalar todas no node_modules/ e criar (ou atualizar) o package-lock.json

   Se ainda existir "package-lock.json" no sistema ao executar `npm install` entao isso garante que as versões exatas travadas no lockfile sejam usadas.

   '

   echo "uDev: Criar .gitignore e adicionar node_modules/"

}

function f_exec {
   f_create_project_directory
   f_config_com_npm
   f_create_all_files
   #f_db
   f_npx 
   f_corrigir_erro
   f_exec_web_server
   f_partilhar_webpage_com_smartphone_browser
   f_partilhar_temporariamente_localhost_com_o_mundo
   f_detect_weather_using_expo_or_not
   f_add_gitignore 
}
f_exec
