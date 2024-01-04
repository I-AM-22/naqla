import { cloneElement } from 'react'

export type ConditionalWrapProps = {
  condition: boolean
  wrap: (children: JSX.Element | null) => JSX.Element
  children: JSX.Element | null
}

export const ConditionalWrap = ({ condition, children, wrap }: ConditionalWrapProps) =>
  condition ? cloneElement(wrap(children)) : children

