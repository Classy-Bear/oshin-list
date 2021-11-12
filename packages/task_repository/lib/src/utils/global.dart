/// El path para crear y obtener tasks.
const apiTask = "https://618c209fded7fb0017bb942a.mockapi.io/task";

/// El path para obtener un task mediante el [id].
String getOneTask(int? id) => "$apiTask/$id";
