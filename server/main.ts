import { Application, Context } from "https://deno.land/x/oak@v17.1.4/mod.ts";
const app = new Application();
app.use(async(ctx)=>{
    let json=await Deno.readTextFile("dane.json");
    ctx.response.body=json;
    ctx.response.type="json"

})
await app.listen({port:3000})