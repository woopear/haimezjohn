module.exports = {
  mode: "jit",
  purge: [
    "./resources/views/**/*.edge",
    "./resources/assets/ts/**/*.ts",
    "./resources/assets/js/**/*.js",
  ],
  darkMode: "class", // or 'media' or 'class'
  content: ["./resources/views/**/*.edge"],
  theme: {
    extend: {
      colors: {
        "violet-fonce": "#1A0029",
        "violet-moyen": "#27003D",
        "violet-claire": "#410066",
        "violet-action": "#AD1FFF",
        "violet-action-fonce": "#8100CC",
        "blue-action": "#4A7AFF",
      },
      fontFamily: {
        body: ["Prompt", "sans-serif"],
      },
    },
  },
  plugins: [],
};
