```bash
# warnings
# https://svelte.dev/docs/accessibility-warnings

# examples
# https://svelte.dev/examples/reactive-declarations
yarn create vite my-svelte --template svelte

yarn add

yarn dev

```

# tailwind UI

```bash
# 定义类名
# postcss-obfuscator

# install

npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init tailwind.config.cjs -p


# tailwind config
cat > tailwind.config.cjs << EOF
module.exports = {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {}
  },
  plugins: []
};
EOF

# add to app.css

@tailwind base;
@tailwind components;
@tailwind utilities;


# add to main.js
import './app.css'


```
