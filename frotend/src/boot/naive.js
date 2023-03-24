import { boot } from "quasar/wrappers";
import naive from "naive-ui";

export default boot(async ({ app, ssrContext }) => {
  //

  app.config.globalProperties.$version_app = "0.0.1";

  app.use(naive);
});
