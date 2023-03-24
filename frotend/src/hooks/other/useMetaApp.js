import { useMeta } from "quasar";
export const useMetaApp = (attrs = {}, appTitle = "Novella Designer App") => {
  useMeta(() => {
    return {
      // whenever "title" from above changes, your meta will automatically update
      title: attrs["title"] || "Create stories! by using ",
      titleTemplate: (title) => `${title} - ${appTitle}`,
      ogTitle: attrs["og_title"] || "Create stories! by using ",
      meta: {
        description: {
          name: "description",
          content:
            attrs["description"] ||
            "Novella Designer is an app for creating stories. With built-in editor! Also, after creation, you can throw it to your friend!",
        },
        "naive-ui-style": {
          name: "naive-ui-style",
        },
        // keywords: { name: "keywords", content: attrs.keywords || "Novella, K"},
        ogTitle: {
          property: "og:title",
          content: `${
            attrs["title"] || "Create stories! by using "
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
