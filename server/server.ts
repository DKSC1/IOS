import { Application, Router } from "https://deno.land/x/oak/mod.ts";

const router = new Router();

router.post("/pay", async (context) => {
  const body = await context.request.body.json();

  // Przykładowe dane do weryfikacji
  const validCard = "123";
  const validCvv = "123";
  const validExpiry = "12/25"; // MM/YY

  if (body.cardNumber === validCard && body.cvv === validCvv && body.expiryDate === validExpiry) {
    context.response.status = 200;
    context.response.body = { success: true, message: "Płatność zaakceptowana" };
  } else {
    context.response.status = 400;
    context.response.body = { success: false, message: "Błędne dane karty" };
  }
});

const app = new Application();
app.use(router.routes());
app.use(router.allowedMethods());

console.log("Serwer uruchomiony na http://localhost:3000");
await app.listen({ port: 3000 });
