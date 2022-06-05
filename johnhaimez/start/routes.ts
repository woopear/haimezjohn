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
    Route.get("/deleteimage/:id", "ProfilsController.deleteImage");
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
    Route.post("/create", "HardskillsController.create");
    Route.post("/update/:id", "HardskillsController.update");
    Route.get("/delete/:id", "HardskillsController.delete");
  }).prefix("/hardskills");

  // soft skills
  Route.group(() => {
    Route.get("/", "SoftskillsController.displaySoftskillPrivate");
    Route.post("/create", "SoftskillsController.create");
    Route.post("/update/:id", "SoftskillsController.update");
    Route.get("/delete/:id", "SoftskillsController.delete");
  }).prefix("/softskills");

  // portfolio
  Route.group(() => {
    Route.get("/", "PortfoliosController.displayPortfolioPrivate");
    Route.post("/create", "PortfoliosController.create");
    Route.post("/update/:id", "PortfoliosController.update");
  }).prefix("/portfolio");

  // project
  Route.group(() => {
    Route.get("/", "ProjectsController.displayProjectPrivate");
    Route.post("/create", "ProjectsController.create");
    Route.post("/update/:id", "ProjectsController.update");
    Route.get("/delete/:id", "ProjectsController.delete");
  }).prefix("/projects");

  // contact
  Route.group(() => {
    Route.get("/", "ContactsController.displayContactPrivate");
    Route.post("/create", "ContactsController.create");
    Route.post("/update", "ContactsController.update");
  }).prefix("/contact");

  // conditions generales
  // mentions-legale
}).prefix("/private");
