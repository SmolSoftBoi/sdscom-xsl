# How to Contribute
This Stylesheet was developed using XSL, Sass and node.js.

## Usage
Be sure to have [Node.js](https://nodejs.org/) installed before proceeding.

```shell
# Clone the repo
git clone https://github.com/EpicKris/sdscom-xsl
cd sdscom-xsl

# Install dependencies
yarn install

# Compile Sass
yarn run css-compile

# Watch Sass for changes (uses nodemon)
yarn run watch

# Start local server (uses sirv-cli)
yarn run server

# Watches Sass for changes and starts a local server
yarn start
```

For the most straightforward development, open two Terminal tabs to execute `yarn run server` and `yarn run watch` at the same time.

Open <http://localhost:3000> to see the page in action.