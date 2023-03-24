import { boot } from "quasar/wrappers";

import UI from "src/components/UI";
// import Antd from 'ant-design-vue';
import naive from "naive-ui";
export default boot(async ({ app }) => {
  //

  app.config.globalProperties.$version_app = "0.0.1";

  //app.use(Antd)
  app.use(naive);
  UI.forEach((uicomp) => {
    app.component(uicomp.name, uicomp);
  });
});
