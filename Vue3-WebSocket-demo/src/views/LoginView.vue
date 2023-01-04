<template>
  <div class="login">
    <el-form
      ref="ruleFormRef"
      :label-position="labelPosition"
      label-width="100px"
      :model="form"
      :rules="rules"
      style="max-width: 460px">
      <el-form-item label="用户名称" prop="userName">
        <el-input v-model="form.userName" />
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="form.password" />
      </el-form-item>
      <el-form-item>
        <el-button :loading="loading" type="primary" @click="handleEnterBtnClick(ruleFormRef)">
          进入聊天室
        </el-button>
        <el-button @click="resetForm(ruleFormRef)">Reset</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script lang="ts" setup>
import { reactive, onMounted, ref} from "vue";
import { useRouter } from "vue-router";
import type { FormInstance, FormRules } from "element-plus";

const router = useRouter();
const loading = ref(false);
const labelPosition = ref("right");
const ruleFormRef = ref<FormInstance>();
const form = reactive({
  userName: "admin",
  password: "",
});
/** 登录表单校验规则 */
const rules = reactive<FormRules>({
  userName: [{ required: true, message: "请输入用户名", trigger: "blur" }],
  password: [
    { required: true, message: "请输入密码", trigger: "blur" },
    { min: 6, max: 16, message: "长度在 6 到 16 个字符", trigger: "blur" },
  ],
});

onMounted(() => {
  form.userName = localStorage.getItem("userName") || "";
  if (form.userName) {
    router.push({ path: "/" });
    return;
  }
});

const handleEnterBtnClick = async (formEl: FormInstance | undefined) => {
  ruleFormRef.value?.validate((valid: boolean) => {
    if (valid) {
      loading.value = true;
      localStorage.setItem('userName',form.userName)
      form.userName = '';
      form.password = '';
      router.push({ path: "/" });
    } else {
      return false;
    }
  });
};
const resetForm = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.resetFields();
};

</script>

<style>
@media (min-width: 1024px) {
  .login {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
