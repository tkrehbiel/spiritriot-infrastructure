npm pkg set scripts.build="npm install"
npm pkg set scripts.run="node index.mjs"
npm pkg set scripts.test="true"
npm install eslint --save-dev
npm pkg set scripts.lint="eslint"
npm install prettier --save-dev
npm pkg set scripts.prettier="prettier --write ."
cp ../dev/.prettierrc.json .
cp ../dev/.eslintrc.json .
