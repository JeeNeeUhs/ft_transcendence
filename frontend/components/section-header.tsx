import { Separator } from "@/components/ui/separator";

export function SectionHeader({
  title,
  description,
  action
}: {
  title: string;
  description?: string;
  action?: React.ReactNode;
}) {
  return (
    <div className="space-y-3">
      <div className="flex items-start justify-between gap-4">
        <div className="space-y-1">
          <h2 className="font-heading text-sm font-medium">{title}</h2>
          {description && <p className="text-xs/relaxed text-muted-foreground">{description}</p>}
        </div>
        {action}
      </div>
      <Separator />
    </div>
  );
}
