### Node Npm
```

# https://nodejs.org/en/

sudo npm install npm -g
sudo npm install npm@latest -g

sudo npm install -g n

sudo n latest
sudo n stable
sudo n lts


npm config set registry https://registry.npm.taobao.org
npm config set registry https://registry.npmjs.org

npm install -g cnpm --registry=https://registry.npm.taobao.org

```

### npm link 本地包
```
cd ~/projects/node-redis    #go into the package directory
npm link                    #creates global link
cd ~/projects/node-bloggy   #go into some other package directory
npm link redis              #link-install the package
```

### 本地包
```
npm install ../libname/dist

# edit angular.json

"architect": {
        "build": {
            "options": {
                "preserveSymlinks":true
            },
        },
}

```

### Angular
```
npm install -g @angular/cli
ng new hello
cd hello
ng serve
ng serve --open
ng g component hello
ng g component hello  -it -is --spec=false
ng g service hello
ng g module app-routing --flat --module=app
ng g directive hello

```
[cli](https://angular.io/cli/generate#component)

### Create-react-app
```
npx create-react-app hello

sudo npm install -g create-react-app
create-react-app hello

```

### React-app-rewired
```
/* config-overrides.js */

module.exports = function override(config, env) {
  //do stuff with the webpack config...
  return config;
}

npm install react-app-rewired --save-dev

# change node_modules/react-app-rewired/scripts/start.js  $webpackConfigPath

```

### React-Script React-app-rewired Mocker-api
```
npm install mocker-api --save-dev

vi mock/index.js

module.exports = {
  'GET /api/profile': {
    name: 'Test',
    userid: 10001,
  },

  'POST /api/register': (req, res) => {
    res.send({
      status: 200,
      statusText: 'ok'
    });
  },
};

vi config-overrides.js

const path = require("path");
const apiMocker = require('mocker-api');

const override = {
    webpack(config, env) {
        return config;
    },
    devServer(configFunction) {
        return (proxy, allowedHost) => {
            let config = configFunction(proxy, allowedHost);
            let before = config.before;
            config.before = (app, server) => {
                apiMocker(app, path.resolve('./mock/index.js'), {
                    proxy: {
                        '/repos/*': 'https://api.github.com/',
                    },
                    changeHost: true,
                });
                before(app, server);
            }
            return config;
        };
    }
}

module.exports = override;

```


### 字体 Icon
[fontmin](https://github.com/ecomfe/fontmin)

```
npm install --save fontmin
npm install --save gulp-rename

var Fontmin = require('fontmin');
var rename = require('gulp-rename');

var src_path = 'fonts/*.ttf';
var out_path = 'build/hdfont';
var out_file = 'hdfont.ttf';


var text = "测试";


var fontmin = new Fontmin()
    .src(src_path)
    .use(rename(out_file))
    .use(Fontmin.glyph({
        text: text
    }))
    .use(Fontmin.ttf2eot())
    .use(Fontmin.ttf2woff())
    .use(Fontmin.ttf2svg())
    .use(Fontmin.css())
    .dest(out_path);

fontmin.run(function (err, files) {
    if (err) {
        throw err;
    }

    console.log(files[0]);
});
```