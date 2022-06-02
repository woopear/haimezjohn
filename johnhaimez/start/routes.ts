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
  Route.get("/profil", "ProfilsController.displayProfilPrivate");
  Route.post("/profil/create", "ProfilsController.create");
  Route.post("/profil/update/:id", "ProfilsController.update");
}).prefix("/private");
