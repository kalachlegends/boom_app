import { useMeta } from "quasar";
export const useMetaApp = (attrs = {}, appTitle = "TenantTracker") => {
  useMeta(() => {
    return {
      // whenever "title" from above changes, your meta will automatically update
      title: attrs["title"] || "Incident manager",
      titleTemplate: (title) => `${title} - ${appTitle}`,
      ogTitle: attrs["og_title"] || "Incident manager",
      meta: {
        description: {
          name: "description",
          content:
            attrs["description"] ||
            "TenanttTracker",
        },
        "naive-ui-style": {
          name: "naive-ui-style",
        },
        // keywords: { name: "keywords", content: attrs.keywords || "Novella, K"},
        ogTitle: {
          property: "og:title",
          content: `${
            attrs["title"] || "Incident manager"
          } - ${appTitle}`,
          // optional; similar to titleTemplate, but allows templating with other meta properties
        },
        ogLocale: { property: "og:locale", content: attrs["locale"] },
        ogType: { property: "og:type", content: attrs["og_type"] || "article" },
        ogImage: {
          property: "og:image",
          content: attrs["og_image"] || "https://i.imgur.com/8ULkD6S.jpg",
        },
        ogwidth: {
          property: "og:image:width",
          content: attrs["og_image_width"],
        },
        ogheight: {
          property: "og:image:height",
          content: attrs["og_image_height"],
        },
        // ogUrl: { property: "og:url", content: url },
      },
      link: {
        // material: {
        //   rel: "stylesheet",
        //   href: "https://fonts.googleapis.com/icon?family=Material+Icons",
        // },
      },

      noscript: {
        default: "This is content for browsers with no JS (or disabled JS)",
      },
    };
  });
};
