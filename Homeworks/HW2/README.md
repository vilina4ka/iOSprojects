## Questions from the task

**Q: What issues prevent us from using storyboards in real projects?**

**A:** Storyboards pose several issues:
- They are XML-based, making conflict resolution and code review challenging.
- Scaling development can be difficult with complex storyboards.
- They lack the flexibility of using code directly for layout and design.

---

**Q: What does the code on lines 25 and 29 do?**

```swift
title.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(title)
```
1. Indicates that Auto Layout constraints will be explicitly provided for `title` instead of relying on autoresizing.
2. Adds `title` as a subview within the container `view`.

---

**Q: What is a safe area layout guide?**

**A:** The safe area layout guide ensures content adapts to different screen sizes and avoids conflicts with system elements.

---

**Q: What is `[weak self]` on line 23, and why is it important?**

**A:** `[weak self]` prevents retain cycles, allowing objects to deallocate when not needed, avoiding memory leaks.

---

**Q: What does `clipsToBounds` mean?**

**A:** This property determines if subviews that extend beyond the view's bounds should be visible.

---

**Q: *What is the `valueChanged` type? What are `Void` and `Double`?**

**A:** `valueChanged` is a `UIControl` event, like those for sliders and switches, triggered upon user interaction. `Void` and `Double` specify data types.
