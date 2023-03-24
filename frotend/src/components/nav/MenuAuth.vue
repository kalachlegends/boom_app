<template>
  <q-no-ssr>
    <n-layout-sider
      bordered
      class="menu-auth"
      collapse-mode="width"
      :collapsed-width="64"
      :width="240"
      :collapsed="collapsed"
      show-trigger
      @collapse="collapsed = true"
      @expand="collapsed = false"
    >
      <n-menu
        :collapsed="collapsed"
        :collapsed-width="64"
        :collapsed-icon-size="22"
        :options="menuOptions"
        :render-label="renderMenuLabel"
        :render-icon="renderMenuIcon"
        :expand-icon="expandIcon"
      />
    </n-layout-sider>
  </q-no-ssr>
</template>
  
  <script>
import { h, ref, defineComponent } from "vue";
import { NIcon } from "naive-ui";
import { BookmarkOutline, CaretDownOutline } from "@vicons/ionicons5";

const menuOptions = [
  {
    label: "Hear the Wind Sing",
    key: "hear-the-wind-sing",
    href: "https://en.wikipedia.org/wiki/Hear_the_Wind_Sing",
  },
  {
    label: "Pinball 1973",
    key: "pinball-1973",
    disabled: true,
    children: [
      {
        label: "Rat",
        key: "rat",
      },
    ],
  },
  {
    label: "A Wild Sheep Chase",
    key: "a-wild-sheep-chase",
    disabled: true,
  },
  {
    label: "Dance Dance Dance",
    key: "Dance Dance Dance",
    children: [
      {
        type: "group",
        label: "People",
        key: "people",
        children: [
          {
            label: "Narrator",
            key: "narrator",
          },
          {
            label: "Sheep Man",
            key: "sheep-man",
          },
        ],
      },
      {
        label: "Beverage",
        key: "beverage",
        children: [
          {
            label: "Whisky",
            key: "whisky",
            href: "https://en.wikipedia.org/wiki/Whisky",
          },
        ],
      },
      {
        label: "Food",
        key: "food",
        children: [
          {
            label: "Sandwich",
            key: "sandwich",
          },
        ],
      },
      {
        label: "The past increases. The future recedes.",
        key: "the-past-increases-the-future-recedes",
      },
    ],
  },
];

export default defineComponent({
  name: "menu-name",
  setup() {
    return {
      menuOptions,
      collapsed: ref(true),
      renderMenuLabel(option) {
        if ("href" in option) {
          return h("a", { href: option.href, target: "_blank" }, [
            option.label,
          ]);
        }
        return option.label;
      },
      renderMenuIcon(option) {
        if (option.key === "sheep-man") return true;
        if (option.key === "food") return null;
        return h(NIcon, null, { default: () => h(BookmarkOutline) });
      },
      expandIcon() {
        return h(NIcon, null, { default: () => h(CaretDownOutline) });
      },
    };
  },
});
</script>

<style lang="scss" scoped >
.menu-auth {
  position: fixed;
  top: 70px;
  left: 0px;
  .n-menu .n-menu-item-content .n-menu-item-content-header a {
    color: white;
  }
  --n-divider-color: rgb(239, 239, 245);
  --n-bezier: cubic-bezier(0.4, 0, 0.2, 1);
  --n-font-size: 14px;
  --n-border-color-horizontal: #0000;
  --n-border-radius: 3px;
  --n-item-height: 42px;
  --n-group-text-color: rgb(118, 124, 130);
  --n-color: rgba(255, 255, 255, 0);
  --n-item-text-color: rgb(51, 54, 57);
  --n-item-text-color-hover: rgb(51, 54, 57);
  --n-item-text-color-active: #18a058;
  --n-item-text-color-child-active: #18a058;
  --n-item-text-color-child-active-hover: #18a058;
  --n-item-text-color-active-hover: #18a058;
  --n-item-icon-color: rgb(31, 34, 37);
  --n-item-icon-color-hover: rgb(31, 34, 37);
  --n-item-icon-color-active: #18a058;
  --n-item-icon-color-active-hover: #18a058;
  --n-item-icon-color-child-active: #18a058;
  --n-item-icon-color-child-active-hover: #18a058;
  --n-item-icon-color-collapsed: rgb(31, 34, 37);
  --n-item-text-color-horizontal: rgb(51, 54, 57);
  --n-item-text-color-hover-horizontal: #36ad6a;
  --n-item-text-color-active-horizontal: #18a058;
  --n-item-text-color-child-active-horizontal: #18a058;
  --n-item-text-color-child-active-hover-horizontal: #18a058;
  --n-item-text-color-active-hover-horizontal: #18a058;
  --n-item-icon-color-horizontal: rgb(31, 34, 37);
  --n-item-icon-color-hover-horizontal: #36ad6a;
  --n-item-icon-color-active-horizontal: #18a058;
  --n-item-icon-color-active-hover-horizontal: #18a058;
  --n-item-icon-color-child-active-horizontal: #18a058;
  --n-item-icon-color-child-active-hover-horizontal: #18a058;
  --n-arrow-color: rgb(51, 54, 57);
  --n-arrow-color-hover: rgb(51, 54, 57);
  --n-arrow-color-active: #18a058;
  --n-arrow-color-active-hover: #18a058;
  --n-arrow-color-child-active: #18a058;
  --n-arrow-color-child-active-hover: #18a058;
  --n-item-color-hover: rgb(243, 243, 245);
  --n-item-color-active: rgba(24, 160, 88, 0.1);
  --n-item-color-active-hover: rgba(24, 160, 88, 0.1);
  --n-item-color-active-collapsed: rgba(24, 160, 88, 0.1);
  .n-menu {
    color: white;
    background-color: #232323;
  }
}
</style>