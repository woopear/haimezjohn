module.exports = {
  mode: "jit",
  darkMode: "class",
  purge: [
    "./resources/views/**/*.edge",
    "./resources/assets/ts/**/*.ts",
    "./resources/assets/js/**/*.js",
  ],
  content: [],
  theme: {
    extend: {
      colors: {
        fc: "#E7F2FF",
        fc2: "#B8D8FF",
        fcb: "#ffffff",
        fd: "#001A39",
        fd2: "#002F69",
        fdb: "#001329",
        ic: "#ffffff",
        id: "#000000",
        ac: "#0094FF",
        ach: "#004B82",
        hc: "#006FFF",
      },
      fontFamily: {
        body: ["Prompt", "sans-serif"],
      },
      fontSize: {
        "size-title-page": "4rem",
        "size-text-menu-header": "1.125rem",
        "size-title-section": "3rem",
        "size-title-box": "2rem",
        "size-title-form": "1.5rem",
        "size-title-article": "1.8rem",
      },
    },
  },
  plugins: [],
};
