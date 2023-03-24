defmodule Manuscript.Generator.Vue.Template do
  @axios_path "import { axios } from \"src/boot/axios.js"
  def template_for_get(title, doc_params, path, method \\ "post") do
  end

  def template_for_send(title, doc_params, path, method \\ "post") do
    """
    <template>
    <n-spin :show="isLoad">
      <n-form
      ref="formRef"
      :label-width="80"
      :model="formState"
      :rules="rules"
      :size="'medium'"
      class="d-f"
      >
        #{generate_inputs(doc_params[:body])}
        <n-button @click="handleValidateClick">
          #{title}
        </n-button>
      </n-form>
    </n-spin>
    </template>
    #{template_scripts_for_send(doc_params[:body], path, method)}
    """
  end

  def generate_inputs(body) do
    if !is_nil(body) do
      get_map_path(body)
      |> Enum.reduce("", fn x, acc ->
        name = x |> String.split(".") |> hd()
        acc <> "\n" <> template_for_inputs(name, x)
      end)
    else
      ""
    end
  end

  def template_for_inputs(name, path, name_state \\ "formState") do
    """
    <n-form-item label="#{name}" path="#{path}">
      <n-input v-model:value="#{name_state}.#{path}" placeholder="#{name}"   />
    </n-form-item>
    """
  end

  def template_scripts_for_send(formState, path, method \\ "post") do
    """
    <script setup>
    #{@axios_path}"
    import {
      requiredRules,
      validateNumber,
      requiredRulesAndValidator,
    } from "@/helper/defaultRules.js";
    import { getOneError } from "@/helper/getOneError.js";
    import { useMessage } from "naive-ui";
    import { ref } from "vue";
    const message = useMessage();
    const isLoad = ref(false);
    const formRef = ref(null);
    const formState = ref(#{Jason.encode!(formState)});
    const rules = {
    
    }
    const handleValidateClick = (e) => {
      e.preventDefault();
      formRef.value?.validate(async (errors) => {
        console.log(errors);
        if (!errors) {
          isLoad.value = true;
          await axios
            .#{method}("#{path}", formState.value)
            .then(({ data }) => {
              console.log(data);
              message.success("Успешно создано!");
            })
            .catch(({ response }) => {
              console.log(response);
              message.error(getOneError(response.data.error));
            });
          isLoad.value = false;
        }
      });
    };
    </script>
    """
  end

  defp reduce_for_get_path(map, paths, accumulated_paths) do
    Enum.reduce(map, paths, fn
      {key, val}, acc when is_map(val) ->
        acc ++ [reduce_for_get_path(val, paths, accumulated_paths ++ [key])]

      {key, val}, acc ->
        acc ++ [{accumulated_paths ++ [key], val}]
    end)
  end

  def get_map_path(map) do
    map
    |> reduce_for_get_path([], [])
    |> List.flatten()
    |> Enum.map(fn {list, _} ->
      Enum.join(list, ".")
    end)
  end
end
