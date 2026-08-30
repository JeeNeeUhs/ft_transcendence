import { Separator } from "@/components/ui/separator";

export function SectionHeader({ title, description }: { title: string; description: string }) {
  return (
    <div className="space-y-3">
      <div className="space-y-1">
        <h2 className="font-heading text-sm font-medium">{title}</h2>
        <p className="text-xs/relaxed text-muted-foreground">{description}</p>
      </div>
      <Separator />
    </div>
  );
}
