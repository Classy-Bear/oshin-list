/// El path para crear y obtener tasks.
const apiTask = "https://618c209fded7fb0017bb942a.mockapi.io/task";

/// El path para eliminar un task mediante el [id].
String deleteTask(int id) => "$apiTask/$id";
