module.exports = {
    "root": true,
    "env": {
        "node": true,
        "browser":true,
        "es6":true
    },
    "parserOptions": {
        "sourceType": "module"
    },
    "parser": "vue-eslint-parser",
    "extends": ["plugin:vue/vue3-essential", "plugin:vue/vue3-strongly-recommended"],
    "rules": {
        "no-console": "off",
        "comma-dangle":[2,"never"]//禁止使用拖尾逗号
    }
};