<template lang="">

<q-no-ssr>
    <n-dropdown
      trigger="click"
    :options="options"
    :show-arrow="true"
    @select="handleSelect"
  > 
            <n-avatar
            round
            :size="48"
            :src="src"
          >
            <slot/>
       </n-avatar>
       </n-dropdown>
</q-no-ssr>
</template>
<script>
import { h } from "vue";
import { useLogout } from "src/hooks/auth/useLogout";
import { NIcon } from "naive-ui";
import {
  PersonCircleOutline as UserIcon,
  Pencil as EditIcon,
  LogOutOutline as LogoutIcon,
} from "@vicons/ionicons5";
export default {
  props: {
    src: String,
  },
  setup() {
    const { handleLogout } = useLogout();
    const renderIcon = (icon) => {
      return () => {
        return h(NIcon, null, {
          default: () => h(icon),
        });
      };
    };
    const handleSelect = (key) => {
      if (key == "logout") {
        handleLogout();
      }
    };

    const options = [
      {
        label: "Profile",
        key: "profile",
        icon: renderIcon(UserIcon),
      },
      {
        label: "Edit Profile",
        key: "editProfile",
        icon: renderIcon(EditIcon),
      },
      {
        label: "Logout",
        key: "logout",
        icon: renderIcon(LogoutIcon),
      },
    ];

    return {
      handleSelect,
      options,
    };
  },
};
</script>
<style lang="scss" scoped>
.n-avatar {
  cursor: pointer;
  color: black;
}
</style>