import Route from "@ioc:Adonis/Core/Route";

// page home
Route.get("/", "HomeController.showHome");

// page connexion user admin
Route.get("/adonis-admin", "AuthController.showLogin").middleware([
  "silentAuth",
]);
// page création user
// !Attention décommenter pour creer un user
//Route.on("/adonis-register").render("register");
// formulaire de connexion
Route.post("/connexion", "AuthController.login");
// deconnexion
Route.delete("/disconnect", "AuthController.logout");
// register user
Route.post("/register", "AuthController.register");

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
    Route.put("/update/:id", "ProfilsController.update");
    Route.get("/deleteimage/:id", "ProfilsController.deleteImage");
  }).prefix("/profil");

  // link
  Route.group(() => {
    Route.get("/", "LinksController.displayLinkPrivate");
    Route.post("/create", "LinksController.create");
    Route.put("/update/:id", "LinksController.update");
    Route.get("/delete/:id", "LinksController.deleteOne");
    Route.get("/deleteimage/:id", "LinksController.deleteImage");
  }).prefix("/links");

  // competence
  Route.group(() => {
    Route.get("/", "CompetencesController.displayCompetencePrivate");
    Route.post("/create", "CompetencesController.create");
    Route.put("/update", "CompetencesController.update");
    Route.get("/deletefile/:id", "CompetencesController.deleteFile");
  }).prefix("/competence");

  // hard skills
  Route.group(() => {
    Route.get("/", "HardskillsController.displayHardskillPrivate");
    Route.post("/create", "HardskillsController.create");
    Route.put("/update/:id", "HardskillsController.update");
    Route.get("/delete/:id", "HardskillsController.delete");
    Route.get("/deleteimage/:id", "HardskillsController.deleteImage");
  }).prefix("/hardskills");

  // soft skills
  Route.group(() => {
    Route.get("/", "SoftskillsController.displaySoftskillPrivate");
    Route.post("/create", "SoftskillsController.create");
    Route.put("/update/:id", "SoftskillsController.update");
    Route.get("/delete/:id", "SoftskillsController.delete");
    Route.get("/deleteimage/:id", "SoftskillsController.deleteImage");
  }).prefix("/softskills");

  // portfolio
  Route.group(() => {
    Route.get("/", "PortfoliosController.displayPortfolioPrivate");
    Route.post("/create", "PortfoliosController.create");
    Route.put("/update/:id", "PortfoliosController.update");
  }).prefix("/portfolio");

  // project
  Route.group(() => {
    Route.get("/", "ProjectsController.displayProjectPrivate");
    Route.post("/create", "ProjectsController.create");
    Route.put("/update/:id", "ProjectsController.update");
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
})
  .prefix("/private")
  .middleware(["auth"]);
