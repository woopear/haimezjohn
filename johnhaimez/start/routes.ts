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

  // link
  Route.group(() => {
    Route.get("/", "LinksController.displayLinkPrivate");
    Route.post("/create", "LinksController.create");
    Route.post("/update/:id", "LinksController.update");
    Route.get("/delete/:id", "LinksController.deleteOne");
  }).prefix("/links");

  // competence
  Route.group(() => {
    Route.get("/", "CompetencesController.displayCompetencePrivate");
    Route.post("/create", "CompetencesController.create");
    Route.post("/update", "CompetencesController.update");
  }).prefix("/competence");

  // hard skills
  Route.group(() => {
    Route.get("/", "HardskillsController.displayHardskillPrivate");
  }).prefix("/hardskills");
}).prefix("/private");
