corepack enable
yarn init -2
npm pkg set scripts.run="node index.mjs"
yarn add eslint --dev
npm pkg set scripts.lint="eslint"
yarn add prettier --dev --exact
npm pkg set scripts.prettier="prettier --write ."
yarn add husky --dev
yarn husky install
npm pkg set scripts.postinstall="husky install"
yarn husky set .husky/pre-commit "yarn prettier && yarn lint && yarn test"
cp ../dev/.prettierrc.json .
#cp ../dev/.prettierignore .
cp ../dev/.eslintrc.json .
