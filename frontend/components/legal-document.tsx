export type LegalSection = {
  title: string;
  paragraphs: string[];
};

type LegalDocumentProps = {
  title: string;
  description: string;
  sections: LegalSection[];
};

export function LegalDocument({ title, description, sections }: LegalDocumentProps) {
  return (
    <main className="mx-auto w-full max-w-6xl px-5">
      <article className="py-14 md:py-20">
        <header className="max-w-3xl border-b pb-10 md:pb-12">
          <h1 className="mt-4 text-4xl font-medium tracking-[-0.035em] text-balance sm:text-5xl">
            {title}
          </h1>
          <p className="mt-5 max-w-2xl text-base leading-7 text-muted-foreground">{description}</p>
        </header>

        <div className="grid max-w-3xl gap-10 pt-10 md:gap-12 md:pt-12">
          {sections.map((section, index) => (
            <section
              key={section.title}
              className="grid gap-4 sm:grid-cols-[2.5rem_minmax(0,1fr)] sm:gap-5"
            >
              <p className="font-mono text-xs text-muted-foreground" aria-hidden="true">
                {String(index + 1).padStart(2, "0")}
              </p>
              <div>
                <h2 className="text-lg font-medium tracking-tight">{section.title}</h2>
                <div className="mt-3 space-y-3 text-sm leading-6 text-muted-foreground">
                  {section.paragraphs.map((paragraph) => (
                    <p key={paragraph}>{paragraph}</p>
                  ))}
                </div>
              </div>
            </section>
          ))}
        </div>
      </article>
    </main>
  );
}
