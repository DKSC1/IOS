import { Application, Router } from "https://deno.land/x/oak/mod.ts";

const app = new Application();
const router = new Router();


const users: { [key: string]: { password: string } } = {};


router.post("/register", async (context) => {
  const body = await context.request.body;
  const { username, password } = await body.json();

  if (users[username]) {
    context.response.status = 400;
    context.response.body = { message: "Username already exists" };
    return;
  }

  users[username] = { password };
  context.response.status = 201;
  context.response.body = { message: "User registered successfully" };
});

router.post("/login", async (context) => {
  const body = await context.request.body;
  const { username, password } = await body.json();

  const user = users[username];

  if (!user || user.password !== password) {
    context.response.status = 400;
    context.response.body = { message: "Invalid username or password" };
    return;
  }

  context.response.status = 200;
  context.response.body = { message: "Login successful" };
});

app.use(router.routes());
app.use(router.allowedMethods());

console.log("Server running on http://localhost:3000");
await app.listen({ port: 3000 });
