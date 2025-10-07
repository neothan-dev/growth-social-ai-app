from PIL import Image
import os

input_dir = "../images"
max_size = 1 * 1024 * 1024  # 1MB (字节)

for root, _, files in os.walk(input_dir):
    for file in files:
        if file.lower().endswith(".jpg"):
            filepath = os.path.join(root, file)
            try:
                original_size = os.path.getsize(filepath)
                if original_size <= max_size:
                    print(f"跳过 (<=1MB): {filepath}")
                    continue

                img = Image.open(filepath)
                quality = 95  # 初始质量
                new_size = original_size

                # 循环压缩直到小于1MB 或 quality太低
                while new_size > max_size and quality > 10:
                    img.save(filepath, optimize=True, quality=quality)
                    new_size = os.path.getsize(filepath)
                    print(f"尝试质量={quality}, 当前大小={new_size/1024:.1f}KB")
                    quality -= 5

                print(f"✅ 已压缩: {filepath}, 原始 {original_size/1024:.1f}KB → 最终 {new_size/1024:.1f}KB, 质量={quality+5}")

            except Exception as e:
                print(f"❌ 处理失败: {filepath}, 错误: {e}")