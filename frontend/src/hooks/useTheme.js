import { REFETCH_LOGO_EVENT } from "@/LogoContext";
import { useEffect } from "react";

const availableThemes = {
  system: "System",
  light: "Light",
  dark: "Dark",
};

/**
 * @typedef {'system' | 'light' | 'dark'} ThemeOption
 */

/**
 * @typedef {Object} UseThemeResult
 * @property {ThemeOption} theme - The current theme preference stored in localStorage.
 * @property {(newTheme: ThemeOption) => void} setTheme - Sets the theme preference.
 * @property {{system: string, light: string, dark: string}} availableThemes - Map of theme keys to display names.
 * @property {boolean} isLight - Whether the resolved theme is light (explicitly or via system preference).
 */

/**
 * Always returns dark theme.
 * theme 硬编码为 "dark"，isLight 硬编码为 false
 * 移除了 useState、matchMedia 监听、dev keybind 等所有切换逻辑
 * 保留 setTheme() 为空函数（no-op），确保调用方不会报错
 * 保留 availableThemes，确保调用方解构不会出错
 * 保留 useEffect 设置 data-theme="dark" 和触发 REFETCH_LOGO_EVENT，确保 DOM 正确应用 dark 模式
 * @returns {UseThemeResult}
 */
export function useTheme() {
  const theme = "dark";
  const isLight = false;

  // Apply dark theme to DOM
  useEffect(() => {
    document.documentElement.setAttribute("data-theme", "dark");
    document.body.classList.remove("light");
    window.dispatchEvent(new Event(REFETCH_LOGO_EVENT));
  }, []);

  /**
   * No-op: theme is always dark, kept for API compatibility.
   * @param {ThemeOption} newTheme The new theme to set
   */
  function setTheme(newTheme) {
    // intentionally empty - theme is always dark
  }

  return {
    theme,
    setTheme,
    availableThemes,
    isLight,
  };
}
