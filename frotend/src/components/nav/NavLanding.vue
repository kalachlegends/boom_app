<template>
  <q-no-ssr>
    <n-config-provider :theme="theme">
      <n-layout>
        <n-layout has-sider>
          <n-layout-sider
            bordered
            show-trigger
            collapse-mode="width"
            :collapsed-width="64"
            :width="240"
            :native-scrollbar="false"
            :inverted="inverted"
          >
            <div class="tw-flex tw-flex-col tw-h-full tw-justify-between">
              <n-menu
                :inverted="inverted"
                :collapsed-width="64"
                :collapsed-icon-size="22"
                :options="menuOptions"
              >
              </n-menu>
              <n-menu
                :inverted="inverted"
                :collapsed-width="64"
                :collapsed-icon-size="22"
                :options="dashBoardOptions"
              >
              </n-menu>
              <n-menu
                :inverted="inverted"
                :collapsed-width="64"
                :collapsed-icon-size="22"
                :options="menuOptionsBottom"
              >
              </n-menu>
            </div>
          </n-layout-sider>
          <n-card>
            <slot></slot>
          </n-card>
        </n-layout>
      </n-layout>
    </n-config-provider>
  </q-no-ssr>
</template>

<script setup>
import { h, defineComponent, ref, computed, onMounted } from "vue";
import { NIcon } from "naive-ui";
import { darkTheme } from "naive-ui";
import { useLogout } from "src/hooks/auth/useLogout";
import {
  BookOutline as BookIcon,
  PersonOutline as PersonIcon,
  WineOutline as WineIcon,
  LogOutOutline,
  MoonOutline,
  Sunny,
  HomeOutline,
  ClipboardOutline,
  Analytics,
} from "@vicons/ionicons5";
import { RouterLink } from "vue-router";
const { handleLogout } = useLogout();
function renderIcon(icon) {
  return () => h(NIcon, null, { default: () => h(icon) });
}
const roles = JSON.parse(localStorage.getItem("roles"))

const isOrg = computed(() => roles.some((p) =>  p == "osi" || p == "ksk"))
const isMan = computed(() => roles.some((p) =>  p == "manager"))
const menuOptions = computed(() => [
  {
    label: () =>
      h(
        RouterLink,
        {
          to: "/",
        },
        "На Главную"
      ),
    key: "go-back-home",
    icon: renderIcon(HomeOutline),
  },
  {
    label: () =>
      h(
        RouterLink,
        {
          to: "/dashboard",
        },
        "Доска"
      ),
    key: "go-dashboard",
    icon: renderIcon(ClipboardOutline),
  },
  {
    label: () =>
      h(
        RouterLink,
        {
          to: "/money",
        },
        "Панель ОСИ/КСК"
      ),
    key: "go-ksk",
    show: isOrg.value,
    icon: renderIcon(),
  },
  {
    label: () =>
      h(
        RouterLink,
        {
          to: "/manage",
        },
        "Создание организации"
      ),
    key: "go-manage",
    show: isMan.value,
    icon: renderIcon(),
  },
]);

const handleChangeTheme = (value) => {
  localStorage.setItem("theme", value);
  if (value == "light") {
    theme.value = null;
  } else theme.value = darkTheme;
};
const theme = ref(darkTheme);
onMounted(() => {
  if (localStorage.getItem("theme") == "light") {
    theme.value = null;
  }
});
const menuOptionsBottom = computed(() => [
  {
    label: () =>
      h(
        "a",
        {
          onClick: () => {
            handleChangeTheme("dark");
          },
        },
        "Тёмная тема"
      ),
    key: "Dark",
    icon: renderIcon(MoonOutline),
  },
  {
    label: () =>
      h(
        "a",
        {
          onClick: () => {
            handleChangeTheme("light");
          },
        },
        "Светлая тема"
      ),
    key: "Light",
    icon: renderIcon(Sunny),
  },
  {
    key: "logout",
    label: () =>
      h(
        "a",
        {
          onClick: () => handleLogout(),
        },
        "Выйти из аккаунта"
      ),
    icon: renderIcon(LogOutOutline),
  },
]);
</script>
<style >
.n-config-provider {
  height: 100%;
}
.n-layout {
  height: 100%;
}
.n-scrollbar > .n-scrollbar-container > .n-scrollbar-content {
  height: 100%;
}
</style>