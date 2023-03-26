// import AppLayoutDefault from 'src/layouts/AppLayoutDefault'

import MainLayout from "layouts/AppLayoutDefault.vue";

const routes = [
  {
    path: "/",
    name: "landing",
    component: () => import("src/pages/dashboard/DashBoard.vue"),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMain",
    },
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: () => import("src/pages/dashboard/DashBoard.vue"),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMain",
    },
  },
  {
    path: "/money",
    name: "money",
    component: () => import("src/pages/money/KskPage.vue"),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMain",
      permissions: ["osi", "ksk"],
    },
  },
  {
    path: "/manage",
    name: "manage",
    component: () => import("src/pages/manager/ManagerView.vue"),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMain",
      permissions: ["manager"]
    },
  },

  {
    path: "/profile/:login",
    name: "profile",
    component: () => import("pages/ProfileView.vue"),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMain",
    },
  },
  {
    path: "/register",
    name: "register",
    component: () => import("pages/auth/RegisterView.vue"),
  },
  {
    path: "/login",
    name: "login",
    component: () => import("src/pages/auth/LoginView.vue"),
  },
  {
    path: "/restore_password",
    name: "restore_password",
    component: () => import("pages/auth/ResetPasswordView.vue"),
  },
  {
    path: "/restore_password/restore",
    name: "restore_password_restore",
    component: () => import("pages/auth/RestorePasswordFromEmailView.vue"),
  },
  {
    path: "/about",
    name: "about",
    component: () => import("pages/AboutView.vue"),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutAdmin",
    },
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/error/NotFound.vue"),
    meta: {
      layout: "AppLayoutMain",
    },
  },
];

export default routes;
