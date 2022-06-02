import Route from "@ioc:Adonis/Core/Route";

// home
Route.get("/", async ({ view }) => {
  return view.render("home");
});

// connexion user admin
Route.get("/adonis-admin", () => {
  return { coucou: "coucou" };
});

// private route
Route.group(() => {
  // dashboard
  Route.get("/", ({ view }) => {
    return view.render("private/dashboard");
  });

  // profil
  Route.group(() => {
    Route.get("/", "ProfilsController.displayProfilPrivate");
    Route.post("/create", "ProfilsController.create");
    Route.post("/update/:id", "ProfilsController.update");
  }).prefix("/profil");

  Route.group(() => {
    Route.get("/", "LinksController.displayLinkPrivate");
  }).prefix("/links");

  // link
}).prefix("/private");
