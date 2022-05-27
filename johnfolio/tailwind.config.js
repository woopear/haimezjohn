module.exports = {
  mode: "jit",
  purge: [
    "./resources/views/**/*.edge",
    "./resources/assets/ts/**/*.ts",
    "./resources/assets/js/**/*.js",
  ],
  darkMode: "class", // or 'media' or 'class'
  content: [],
  theme: {
    extend: {},
  },
  plugins: [],
};
