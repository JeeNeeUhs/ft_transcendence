# İsimlendirme Kuralları
Geliştirme süreçleri boyunca standart sağlamak adına aşağıdaki kurallar uygulanmalıdır:

## 1. Issue ve Pull Request Başlıkları
Issue ve PR oluştururken başlık formatı standart olarak `<type>: <short description>` şeklinde olmalıdır. Sadece aşağıdaki scope'lar kullanılacaktır:

- `feat`: Yeni bir özellik eklenmesi
- `refactor`: Mevcut kodun davranışını değiştirmeden iyileştirilmesi
- `bug`: Hatalı çalışan bir yerin düzeltilmesi
- `chore`: Derleme süreci, paket yönetimi veya dış araçlarla ilgili rutin işler
- `docs`: Dokümantasyonla ilgili ekleme veya düzenlemeler

**Issue/PR Başlığı Örnekleri:**
- `feat: add user authentication`
- `feat: create dashboard layout`
- `refactor: simplify calculate total function`
- `refactor: clean up unused variables`
- `bug: resolve null pointer in user profile`
- `bug: fix text overflow on mobile screens`
- `chore: update dependencies`
- `chore: configure github actions`
- `docs: update readme with setup instructions`
- `docs: add api reference`

## 2. Commit Mesajları
Commit atarken [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) standartlarına uyulmalıdır. Issue/PR etiketlerinden farklı olarak, commit tiplerinde Conventional Commits'in kendi standart tipleri (`fix`, `feat`, `hotfix`, `style` vb.) geçerlidir.

**Commit Mesajı Örnekleri:**
- `feat(auth): implement login api endpoint`
- `feat(reports): add export button to reports`
- `fix(ui): prevent duplicate form submissions`
- `refactor: move constants to config file`
- `perf(db): optimize database queries`
- `chore(deps): bump webpack version`
- `chore(lint): add prettier formatting rules`
- `docs: fix typo in installation guide`
- `docs: clarify branching strategy`

Github Copilot'un VSCode'da commit mesajı üreten AI modeli için aşağıdaki ayar kullanılabilir:
```json
"github.copilot.chat.commitMessageGeneration.instructions": [
    { "text": "Analyze the provided git diff of staged changes and generate a high-quality Git commit message following the Conventional Commits specification." },
    { "text": "Format: <type>([optional scope]): <short description in imperative mood>" },
    { "text": "Allowed Types: feat, fix, docs, style, refactor, perf, test, chore" },
    { "text": "A commit message must be under 50 characters." },
    { "text": "Use the imperative, present tense ('add' not 'added', 'change' not 'changes')." },
    { "text": "Do not capitalize the first letter of the description." },
    { "text": "Do not end the commit message with a period." },
    { "text": "Return ONLY the final commit message. Do not include markdown code block syntax (```), conversational filler, or explanations." }
]
```
