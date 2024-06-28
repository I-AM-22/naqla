import { cn } from "@/lib/utils";
import { Slot } from "@radix-ui/react-slot";
import React, {
  ComponentPropsWithoutRef,
  FocusEvent,
  ReactNode,
  useState,
} from "react";

export type InplaceProps = ComponentPropsWithoutRef<"div">;

export const Inplace: React.FC<InplaceProps> = ({
  children,
  className,
  ...props
}) => {
  const [isEditing, setIsEditing] = useState(false);

  const handleDisplayClick = () => {
    setIsEditing(true);
  };
  const handleClose = () => {
    setIsEditing(false);
  };

  const handleBlur = (_e: FocusEvent<HTMLDivElement>) => {
    // if (!e.currentTarget.contains(e.relatedTarget as Node)) {
    //   setIsEditing(false);
    // }
  };

  return (
    <div
      tabIndex={0}
      {...props}
      onBlur={handleBlur}
      className={cn("flex", className)}
    >
      {React.Children.map(children, (child) => {
        if (React.isValidElement(child)) {
          if (child.type === InplaceDisplay && !isEditing) {
            return React.cloneElement(child, {
              onClick: handleDisplayClick,
            } as any);
          }
          if (child.type === InplaceContent && isEditing) {
            return child;
          }
          if (child.type === InplaceClose && isEditing) {
            return React.cloneElement(child, { onClick: handleClose } as any);
          }
        }
        return null;
      })}
    </div>
  );
};

interface InplaceDisplayProps {
  children: ReactNode;
  onClick?: () => void;
}

export const InplaceDisplay: React.FC<InplaceDisplayProps> = ({
  children,
  onClick,
}) => {
  return <Slot onClick={onClick}>{children}</Slot>;
};

interface InplaceContentProps {
  children: ReactNode;
}

export const InplaceContent: React.FC<InplaceContentProps> = ({ children }) => {
  return <Slot>{children}</Slot>;
};

interface InplaceCloseProps {
  onClick?: () => void;
  children: ReactNode;
}
export const InplaceClose: React.FC<InplaceCloseProps> = ({
  onClick,
  children,
}) => {
  return <Slot onClick={onClick}>{children}</Slot>;
};
